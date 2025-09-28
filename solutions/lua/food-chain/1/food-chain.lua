local animals = {
  "fly",
  "spider",
  "bird",
  "cat",
  "dog",
  "goat",
  "cow",
  "horse"
}

local extras = {
  [2] = "It wriggled and jiggled and tickled inside her.",
  [3] = "How absurd to swallow a bird!",
  [4] = "Imagine that, to swallow a cat!",
  [5] = "What a hog, to swallow a dog!",
  [6] = "Just opened her throat and swallowed a goat!",
  [7] = "I don't know how she swallowed a cow!",
  [8] = "She's dead, of course!"
}

local function swallow_chain(n)
  local lines = {}
  for i = n, 2, -1 do
    local predator = animals[i]
    local prey = animals[i - 1]
    if prey == "spider" then
      table.insert(lines, ("She swallowed the %s to catch the %s that wriggled and jiggled and tickled inside her."):format(predator, prey))
    else
      table.insert(lines, ("She swallowed the %s to catch the %s."):format(predator, prey))
    end
  end
  return table.concat(lines, "\n")
end

local function verse(which)
  assert(type(which) == "number" and which >= 1 and which <= #animals, "verse: which out of range")
  local out = {}

  table.insert(out, ("I know an old lady who swallowed a %s."):format(animals[which]))

  if extras[which] then
    table.insert(out, extras[which])
  end

  if animals[which] ~= "horse" then
    if which >= 2 then
      table.insert(out, swallow_chain(which))
    end
    table.insert(out, "I don't know why she swallowed the fly. Perhaps she'll die.")
  end


  return table.concat(out, "\n") .. "\n"
end

local function verses(from, to)
  assert(type(from) == "number" and type(to) == "number", "verses: numeric range required")
  assert(from >= 1 and to <= #animals and from <= to, "verses: invalid range")
  local parts = {}
  for i = from, to do
    table.insert(parts, verse(i))
  end
  
  return table.concat(parts, "\n") .. "\n"
end

local function sing()
  return verses(1, #animals)
end

return { verse = verse, verses = verses, sing = sing }
