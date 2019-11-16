class File
  def self.wait_until_file_is_written_to_disk(file_path, check_interval = 0.1, max_wait = 10.0)
    time = 0.0
    while !File.exist? file_path and time < max_wait
      sleep check_interval
      time += check_interval
    end
  end
end
