require 'spec_helper'
require 'lisp/parser'
require 'lisp/compiler'

RSpec.describe 'bootstraping' do

  it 'parses the file' do
    root = File.expand_path('../..', __FILE__)
    core_lisp_filepath = File.join(root, 'lib/core.lisp')
    content = File.read(core_lisp_filepath)
    ast = Lisp::Parser.parse_string(content)
    p ast.map(&:to_s)
    compiled_code = Lisp::Compiler.compile(ast)
    p compiled_code
  end

end
