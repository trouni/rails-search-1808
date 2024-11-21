class Movie < ApplicationRecord
  belongs_to :director

  include PgSearch::Model
  multisearchable against: [:title, :synopsis]
  pg_search_scope :search,
    against: [:title, :synopsis],
    associated_against: {
      director: [:first_name, :last_name]
    },
    using: {
      tsearch: {
        prefix: true,  # <-- now `superman batm` will return something!
        highlight: {
          StartSel: '<b>',
          StopSel: '</b>',
          MaxWords: 123,
          MinWords: 456,
          ShortWord: 4,
          HighlightAll: true,
          MaxFragments: 3,
          FragmentDelimiter: '&hellip;'
        }
      }
    }
  # pg_search_scope :search_only_by_title, against: [:title]
end
