player1 = Player.create(name: "Charlie")
player2 = Player.create(name: "Matias")
Match.create!(
  winner_faction: "Protoss",
  loser_faction: "Terran",
  duration: 30,
  date: 5.days.from_now,
  winner_id: player1.id,
  loser_id: player2.id)
