
class Chef::Node
  def generate_radicale_ini(hash)
    return nil if hash.nil?
    lines = []

    lines << '# Generated by Chef'
    lines << ''

    hash.each do |section_name,section_hash|
      lines << "[#{section_name}]"
      generate_radicale_ini_section(lines, section_hash)
      lines << ""
    end

    lines << ''
    lines.join "\n"
  end

  private

  def generate_radicale_ini_section(lines, section_hash)
    section_hash.each do |key,value|
      # Does not work as intended because deep merge ignores nil values always so no reset possible
      next if value.nil? # skip nil values -> support deleting a presetted value
      lines << "#{key} = #{value}"
    end
  end
end
