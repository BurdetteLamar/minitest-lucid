require 'minitest/autorun'
require 'diff/lcs'
require 'rexml/document'
require 'fileutils'

require_relative 'lucid/lucid_set'

module Minitest

  module Assertions

    alias minitest_assert_equal assert_equal

    def assert_equal(expected, actual, msg=nil)
      begin
        minitest_assert_equal(expected, actual, msg)
      rescue Minitest::Assertion => x
        elucidation_class  = get_class(expected, actual)
        raise unless elucidation_class

        elucidation_class.new.elucidate(self, x, expected, actual)
      end
    end

    ELUCIDATABLE_CLASSES = [
      Set,
    ]
    STYLES = <<EOT
        
    .good {color: rgb(0,97,0) ; background-color: rgb(198,239,206) }
    .neutral { color: rgb(156,101,0) ; background-color: rgb(255,236,156) }
    .bad { color: rgb(156,0,6); background-color: rgb(255,199,206) }
    .data { font-family: Courier New, monospace }
    .data_changed { font-family: Courier New, monospace; font-weight: bold; font-style: italic }
EOT

    # Poll with kind_of?.
    def get_class(expected, actual)
      ELUCIDATABLE_CLASSES.each do |klass|
        next unless expected.kind_of?(klass)
        next unless actual.kind_of?(klass)
        class_name = "Lucid#{klass.name}"
        return Object.const_get(class_name)
      end
      nil
    end

    def self.elucidate(test, exception, expected, actual)
      # Start HTML doc.
      doc = REXML::Document.new
      html_ele = doc.add_element('html')
      head_ele = html_ele.add_element('head')
      head_ele.attributes['title'] = 'Elucidation'
      style_ele = head_ele.add_element('style')
      style_ele.text = STYLES
      @body_ele = html_ele.add_element('body')
      h1_ele = @body_ele.add_element('h1')
      h1_ele.text = 'Elucidation'
      @toc_ul_ele = @body_ele.add_element('ul')
      Minitest::Assertions.elucidate_expected_items(expected)
      Minitest::Assertions.elucidate_actual_items(actual)
      yield
      # Finish HTML doc.
      Minitest::Assertions.elucidate_exception(exception)
      Minitest::Assertions.elucidate_backtrace(exception)
      home = ENV['HOME'].gsub(File::ALT_SEPARATOR, File::SEPARATOR)
      dir_path = File.join(home, '.minitest-lucid')
      FileUtils.mkdir_p(dir_path)
      file_path = File.join(dir_path, test.name + '.html')
      file = File.open(file_path, 'w')
      doc.write(:output => file, :indent => 0)
      file.close
      new_message = "Your elucidation is in #{file.path}"
      new_exception = exception.exception(new_message)
      new_exception.set_backtrace(exception.backtrace)
      raise new_exception
    end

    def self.toc_link(id)
      li_ele = REXML::Element.new('li')
      a_ele = li_ele.add_element('a')
      a_ele.attributes['href'] = "##{id}"
      a_ele.text = id.capitalize
      li_ele
    end

    def self.section_header(level, id, header_text)
      h_ele = REXML::Element.new("h#{level}")
      h_ele.attributes['id'] = id
      h_ele.text = header_text
      h_ele
    end

    def self.items_table(class_names, items)
      table_ele = REXML::Element.new('table')
      table_ele.attributes['border'] = '1'
      # Header row.
      tr_ele = table_ele.add_element('tr')
      th_ele = tr_ele.add_element('th')
      th_ele.text = 'Class'
      th_ele = tr_ele.add_element('th')
      th_ele.text = 'Inspect Value'
      # Data rows.
      items.each do |item|
        tr_ele = table_ele.add_element('tr')
        td_ele = tr_ele.add_element('td')
        td_ele.attributes['class'] = class_names
        td_ele.text = item.class.name
        td_ele = tr_ele.add_element('td')
        td_ele.attributes['class'] = class_names
        td_ele.text = item.inspect
      end
      table_ele
    end

    def self.elucidate_exception(exception)
      id = 'exception'
      @toc_ul_ele.add_element(self.toc_link(id))
      @body_ele.add_element(self.section_header(3, id, 'Exception'))
      table_ele = @body_ele.add_element('table')
      table_ele.attributes['border'] = '1'
      tr_ele = table_ele.add_element('tr')
      th_ele = tr_ele.add_element('th')
      th_ele.text = 'Class'
      td_ele = tr_ele.add_element('td')
      td_ele.text = exception.class.name
      tr_ele = table_ele.add_element('tr')
      th_ele = tr_ele.add_element('th')
      th_ele.text = 'Message'
      td_ele = tr_ele.add_element('td')
      td_ele.text = exception.message
      tr_ele = table_ele.add_element('tr')
      th_ele = tr_ele.add_element('th')
      th_ele.text = 'Backtrace'
      td_ele = tr_ele.add_element('td')
      td_ele.add_element(items_table('data', exception.backtrace))
    end

    def self.git_dir_path
      `git rev-parse --show-toplevel`.chomp
    end

    def self.gsub_git_dir!(text, s)
      text.gsub!(Regexp.new(git_dir_path), s)
    end

    def self.gem_dir_path
      File.dirname(`gem which minitest`)
    end

    def self.gsub_gem_dir!(text, s)
      text.gsub!(Regexp.new(gem_dir_path), s)
    end

    def self.gsub_line_no!(text, s)
      text.gsub!(/\.rb:\d+:in/, '.rb:&lt;LINE_NO&gt;:in')
    end

    def self.elucidate_backtrace(exception)
      backtrace = exception.backtrace.clone
      id = 'backtrace'
      @toc_ul_ele.add_element(toc_link(id))
      @body_ele.add_element(section_header(3, id, 'Backtrace (Filtered)'))
      gem_dir_path = File.dirname(`gem which minitest`)
      while backtrace.first.start_with?(gem_dir_path)
        backtrace.shift
      end
      while backtrace.last.start_with?(gem_dir_path)
        backtrace.pop
      end
      @body_ele.add_element(items_table('data', backtrace))
    end

    def self.elucidate_items(class_names, id, header_text, items)
      @toc_ul_ele.add_element(self.toc_link(id))
      @body_ele.add_element(self.section_header(3, id, header_text))
      @body_ele.add_element(self.items_table(class_names, items)) unless items.empty?
    end

    def self.elucidate_expected_items(expected)
      id = 'Expected'
      header_text = "#{id}:  class=#{expected.class} size=#{expected.size}"
      Minitest::Assertions.elucidate_items('data', id, header_text, expected)
    end

    def self.elucidate_actual_items(actual)
      id = 'Got'
      header_text = "#{id}:  class=#{actual.class} size=#{actual.size}"
      Minitest::Assertions.elucidate_items('data', id, header_text, actual)
    end

    def self.elucidate_missing_items(missing)
      id = 'Missing'
      header_text = "#{id} items: #{missing.size}"
      Minitest::Assertions.elucidate_items('bad data', id, header_text, missing)
    end

    def self.elucidate_unexpected_items(unexpected)
      id = 'Unexpected'
      header_text = "#{id} items: #{unexpected.size}"
      Minitest::Assertions.elucidate_items('bad data', id, header_text, unexpected)
    end

    def self.elucidate_ok_items(ok)
      id = 'Ok'
      header_text = "#{id} items: #{ok.size}"
      Minitest::Assertions.elucidate_items('good data', id, header_text, ok)
    end

  end

end
