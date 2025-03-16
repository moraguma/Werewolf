extends Node
class_name WolfVotingSystem

static var votes = {}

## Registra um voto de um lobo
static func register_vote(wolf, target):
	if not votes[target]:
		votes[target] = 0
	
	votes[target] += 1

## Obtém os votos atuais dos lobos
static func get_votes():
	return votes

static func get_most_voted_player():
	if votes.is_empty():
		return null

	var max_votes = votes.values().max()
	var most_voted_players = votes.filter(func(target, count): return count == max_votes).keys()

	if most_voted_players.size() > 1 and not FeatureFlags.WOLVES_KILL_ON_TIE:
		return null

	return most_voted_players.front()
	
