class ChatsRepresenter < BaseRepresenter
  def render(resource)
    {
      number: resource.number.to_i,
      messages_count: resource.messages_count.to_i,
      created_at: resource.created_at,
      updated_at: resource.updated_at
    }
  end
end
