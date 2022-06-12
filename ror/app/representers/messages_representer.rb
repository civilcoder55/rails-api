class MessagesRepresenter < BaseRepresenter
  def render(resource)
    {
      number: resource.number,
      body: resource.body,
      created_at: resource.created_at,
      updated_at: resource.updated_at
    }
  end
end
