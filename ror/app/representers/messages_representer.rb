class MessagesRepresenter < BaseRepresenter
  def render(resource)
    {
      number: resource.number.to_i,
      body: resource.body,
      created_at: resource.created_at,
      updated_at: resource.updated_at
    }
  end
end
