
local function build_adjacency(node, adjacency, parent_of, children_order)
  adjacency = adjacency or {}
  parent_of = parent_of or {}
  children_order = children_order or {}

  if type(node) ~= "table" then
    return adjacency, parent_of, children_order
  end

  local name = node[1]
  adjacency[name] = adjacency[name] or {}
  children_order[name] = children_order[name] or {}

  local children = node[2] or {}
  for i = 1, #children do
    local child = children[i]
    local child_name = child[1]

    adjacency[child_name] = adjacency[child_name] or {}

    table.insert(adjacency[name], child_name)
    table.insert(adjacency[child_name], name)

    parent_of[child_name] = name
    table.insert(children_order[name], child_name)

    build_adjacency(child, adjacency, parent_of, children_order)
  end

  return adjacency, parent_of, children_order
end

local function build_tree_from_adjacency(name, parent, adjacency, parent_of, children_order, seen)
  seen = seen or {}
  seen[name] = true

  local children_list = {}

  local orig_children = children_order[name] or {}
  for i = 1, #orig_children do
    local child = orig_children[i]
    if child ~= parent and not seen[child] then
      table.insert(children_list, build_tree_from_adjacency(child, name, adjacency, parent_of, children_order, seen))
    end
  end

  local orig_parent = parent_of[name]
  if orig_parent and orig_parent ~= parent and not seen[orig_parent] then
    table.insert(children_list, build_tree_from_adjacency(orig_parent, name, adjacency, parent_of, children_order, seen))
  end

  local neighbors = adjacency[name] or {}
  for i = 1, #neighbors do
    local nb = neighbors[i]
    if nb ~= parent and nb ~= orig_parent then
      if not seen[nb] then
        table.insert(children_list, build_tree_from_adjacency(nb, name, adjacency, parent_of, children_order, seen))
      end
    end
  end

  if #children_list == 0 then
    return { name }
  end

  return { name, children_list }
end

local function pov_from(target)
  return {
    of = function(tree)
      if type(tree) ~= "table" then
        error("pov_from: tree must be a table")
      end

      local adjacency, parent_of, children_order = build_adjacency(tree)
      if not adjacency[target] then
        error("pov_from: node " .. tostring(target) .. " not in tree")
      end

      return build_tree_from_adjacency(target, nil, adjacency, parent_of, children_order)
    end
  }
end

local function bfs_path(adjacency, src, dst)
  local queue = { src }
  local visited = {}
  visited[src] = true
  local predecessor = {}
  local qi = 1

  while qi <= #queue do
    local cur = queue[qi]; qi = qi + 1
    if cur == dst then break end

    for i = 1, #(adjacency[cur] or {}) do
      local nb = adjacency[cur][i]
      if not visited[nb] then
        visited[nb] = true
        predecessor[nb] = cur
        table.insert(queue, nb)
      end
    end
  end

  if not visited[dst] then return nil end

  local path = {}
  local cur = dst
  while cur do
    table.insert(path, 1, cur)
    if cur == src then break end
    cur = predecessor[cur]
  end

  return path
end

local function path_from(src)
  return {
    to = function(dst)
      return {
        of = function(tree)
          if type(tree) ~= "table" then
            error("path_from: tree must be a table")
          end

          local adjacency = build_adjacency(tree)
          if type(adjacency) ~= "table" then
            adjacency = ({ build_adjacency(tree) })[1]
          end

          if not adjacency[src] then
            error("path_from: node " .. tostring(src) .. " not in tree")
          end
          if not adjacency[dst] then
            error("path_from: node " .. tostring(dst) .. " not in tree")
          end

          local path = bfs_path(adjacency, src, dst)
          if not path then
            error("path_from: no path between " .. tostring(src) .. " and " .. tostring(dst))
          end

          return path
        end
      }
    end
  }
end

return {
  pov_from = pov_from,
  path_from = path_from
}
