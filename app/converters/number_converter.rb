class NumberConverter
  def convert(number)
    perform_conversion (number) unless does_not_exist?(number)
  end

  private

  def does_not_exist?(number)
    !number || number.eql?('N/A') || number.eql?('nan')
  end

  def perform_conversion(number)
    if number[-1].eql?('B')
      number.to_f * (10**9)
    elsif number[-1].eql?('M')
      number.to_f * (10**6)
    else
      number.to_f
    end
  end
end
