class ChatsRepresenter < BaseRepresenter
  def render(resource)
    {
      number: resource.number,
      messages_count: resource.messages_count,
      created_at: resource.created_at,
      updated_at: resource.updated_at
    }
  end
end
