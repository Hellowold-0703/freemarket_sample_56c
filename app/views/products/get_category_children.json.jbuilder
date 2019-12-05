json.array! @category_children do |child|
  json.id child.id
  json.name child.name
  json.size_type_id child.size_type_id
end