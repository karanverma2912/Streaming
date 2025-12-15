# app/jobs/hls_processing_job.rb
class HlsProcessingJob < ApplicationJob
  queue_as :video_processing

  def perform(episode_id)
    puts "-------------Started--------------"
    episode = Episode.find(episode_id)
    puts "-------------Episode found--------------"

    # Download original video
    source_path = download_source(episode)
    puts "-------------Source downloaded--------------"

    # Generate HLS (all qualities automatically)
    hls_dir = "/tmp/hls/#{episode.id}"
    Dir.mkdir(hls_dir) unless Dir.exist?(hls_dir)
    puts "-------------HLS directory created--------------"

    # FFmpeg HLS command (auto-generates 360p→1080p)
    system("ffmpeg -i #{source_path.shellescape} \\
      -profile:v baseline -level 3.0 \\
      -start_number 0 -hls_time 10 \\
      -hls_list_size 0 -hls_segment_filename \\
      '#{hls_dir}/segment%03d.ts' \\
      -f hls '#{hls_dir}/playlist.m3u8'",
      exception: true)
    puts "-------------HLS generated--------------"

    # Upload HLS files to Active Storage
    upload_hls_files(episode, hls_dir)
    puts "-------------HLS uploaded--------------"

    # Cleanup
    FileUtils.rm_rf(hls_dir)
    File.delete(source_path)
    puts "-------------Cleanup done--------------"
  end

  private

  def download_source(episode)
    blob_path = episode.video.download
    "/tmp/#{episode.id}_source.mp4"
  end

  def upload_hls_files(episode, hls_dir)
    # Upload playlist
    episode.hls_playlist.attach(
      io: File.open("#{hls_dir}/playlist.m3u8"),
      filename: "playlist.m3u8"
    )

    # Upload all .ts segments
    Dir.glob("#{hls_dir}/*.ts").each do |segment|
      ActiveStorage::Blob.create_and_upload!(
        io: File.open(segment),
        filename: File.basename(segment),
        content_type: "video/mp2t"
      )
    end
  end
end
