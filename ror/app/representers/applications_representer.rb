class ApplicationsRepresenter < BaseRepresenter
  def render(resource)
    {
      name: resource.name,
      token: resource.token,
      chats_count: resource.chats_count.to_i,
      created_at: resource.created_at,
      updated_at: resource.updated_at
    }
  end
end
