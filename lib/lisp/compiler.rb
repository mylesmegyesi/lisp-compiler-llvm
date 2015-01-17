require 'llvm/core'
require 'llvm/execution_engine'

module Lisp
  class Compiler
    def self.compile(forms)
      self.new.compile(forms)
    end

    HELLO_STRING = 'Hello, World!'

    def compile(forms)
      mod = LLVM::Module.new('hello')

      hello = mod.globals.add(LLVM::ConstantArray.string(HELLO_STRING) , :hello) do |var|
        var.linkage = :private
        var.global_constant = 1
        var.unnamed_addr = true
        var.initializer = LLVM::ConstantArray.string(HELLO_STRING)
      end

      # External declaration of the `puts` function
      cputs = mod.functions.add('puts', [LLVM.Pointer(LLVM::Int8)], LLVM::Int32) do |function, string|
        function.add_attribute :no_unwind_attribute
        string.add_attribute :no_capture_attribute
      end

      # Definition of main function
      # a function is made up of connected BasicBlocks and must have _one entry and exit
      # basic blocks are (mostly) simple machine instructions and can be connected in a graph
      main = mod.functions.add('main', [], LLVM::Int32) do |function|
        function.basic_blocks.append.build do |b|
          zero = LLVM.Int(0) # a LLVM Constant value

          # Read here what GetElementPointer (gep) means http://llvm.org/releases/3.2/docs/GetElementPtr.html
          # Convert [13 x i8]* to i8  *...
          first_hello_word_character = b.gep hello, [zero, zero]
          # Call puts function to write out the string to stdout.
          b.call cputs, first_hello_word_character
          b.ret LLVM.Int(0)
        end
      end

      module_content = mod.to_s
      puts module_content.class
      puts module_content
      File.write('main.ll', module_content)

      LLVM.init_jit
      jit = LLVM::JITCompiler.new(mod)
      puts jit.run_function(mod.functions['main'])
    end

    private

  end
end
