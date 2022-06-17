namespace :es do
  desc 'sync elasticsearch'
  task sync: :environment do
    unless Message.__elasticsearch__.exists?
      Message.__elasticsearch__.create_index!
      Message.__elasticsearch__.import
    end
  end
end
