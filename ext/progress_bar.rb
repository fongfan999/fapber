class ProgressBar
  def self.display(current, total)
    progress = 'Progress ['
    percents = (current.to_f / total * 100).round(0)
    progress << '=' * percents

    print "\r"
    print "#{progress}> #{percents}%]"
  end

  def self.finish
    print "\r"
    print "Progress [#{'=' * 100}> 100%]"
    puts
  end
end