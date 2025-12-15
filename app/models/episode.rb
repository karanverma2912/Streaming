# app/models/episode.rb
class Episode < ApplicationRecord
  belongs_to :season
  has_one_attached :video  # Original 1080p upload
  has_one_attached :hls_playlist  # Generated playlist.m3u8
  has_one_attached :thumbnail

  after_create :process_hls_video  # Auto-generate HLS

  private

  def process_hls_video
    HlsProcessingJob.perform_later(self.id) if video.attached?
  end
end
