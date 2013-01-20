module MusicBrainz
  class Release < BaseModel
    field :id, String
    field :title, String
    field :status, String
    field :format, String
    field :date, Date
    field :country, String

    def tracks
      @tracks ||= client.load(:release, { id: id, inc: [:recordings, :media], limit: 100 }, {
        binding: :release_tracks,
        create_models: :track,
        sort: :position
      }) unless @id.nil?
    end

    class << self
      def find(id)
        client.load(:release, { id: id, inc: [:media] }, {
          binding: :release,
          create_model: :release
        })
      end
    end
  end
end
