# app/controllers/api/v1/episodes_controller.rb
class Api::V1::EpisodesController < ApplicationController
  def show
    @episode = Episode.find(params[:id])

    render json: {
      episode: {
        id: @episode.id,
        number: @episode.number,
        title: @episode.title,
        hls_url: hls_streaming_url(@episode),
        thumbnail_url: @episode.thumbnail.url(host: request.host_with_port)
      }
    }
  end

  private

  def hls_streaming_url(episode)
    if episode.hls_playlist.attached?
      episode.hls_playlist.url(host: request.host_with_port)
    else
      episode.source_video.url(host: request.host_with_port)
    end
  end
end
