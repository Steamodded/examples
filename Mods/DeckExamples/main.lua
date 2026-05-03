local file_names = {
    "AbsoluteDeck",
    "DeckOf4s",
    "LabyrinthDeck",
    "UltimateRandom"
}

for _, file_name in ipairs(file_names) do
    assert(SMODS.load_file(file_name .. ".lua"))()
end
