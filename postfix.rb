class PostfixCalculator
    def initialize(expression)
        @symbols = str_to_nums(expression)
    end

    def calculate
        answer = evaluate_symbols
        return answer.first if answer.length == 1
        answer
    end

    private

    def str_to_nums(expression)
        symbol_strs = expression.split(" ")
        symbol_strs.map do |str|
            case str
            when /[+-\/\*]/
                str.to_sym
            else
                str.to_f
            end
        end
    end

    def evaluate_symbols
        @symbols.reduce([]) do |stack, symbol|
            if (symbol.is_a?(Symbol))
                operator1 = stack.pop
                operator2 = stack.pop
                operand = symbol
                stack << operator2.send(operand, operator1)
            else
                stack << symbol
            end
            stack
        end
    end
end