users = Domain::Store.model(:user)
users.create(call_name: 'user', password: 'only', role: 'user')
trees = Domain::Store.model(:tree)
{ 'birch' => 'betula', 'oak' => 'quercus' }.each_pair do |common, latin|
  trees.create(common_name: common,
               latin_name: latin,
               positionable: true)
end
[[40.0, 50.0, 1, 1], [50.0, 60.0, 2, 2]].each do |attrs|
  Domain::Position.create(longitude: attrs[0],
                          latitude: attrs[1],
                          living: true,
                          creator_id: attrs[2],
                          tree_id: attrs[3])
end
