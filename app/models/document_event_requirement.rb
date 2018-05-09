class DocumentEventRequirement < EventRequirement
  def completed_by?(person)
    false
  end
end
