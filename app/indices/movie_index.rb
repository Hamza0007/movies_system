ThinkingSphinx::Index.define :movie, with: :active_record do
  indexes title, sortable: true
  indexes description
  indexes genre
  indexes actors.name

  has approved
end
