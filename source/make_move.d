import std.array;
import std.algorithm;
import std.conv;
import std.format;
import std.json;
import std.range;
import std.stdio;
import std.string;
import std.traits;
import std.typecons;

enum MoveDirection
{
	None = -1, Up, Down, Right, Left
};

enum BotAction
{
	None, DropBomb, FireMissle
};

enum BoardTile
{
	Empty, 
	Regular,
	Fortified,
	Indestructible
}

struct Missle
{
	.MoveDirection MoveDirection;
	string Location;
	int ExplosionRadius; 
}

struct Bomb
{
	int RoundUntilExplodes;
	string Location;
	int ExplosionRadius;
}

struct GameConfig
{
	int MapWidth;
	int MapHeight;
	int BombBlastRadius;
	int MissleBlastRadius;
	int RoundsBetweenMissles;
	int RouundBeforeIncreasingBlastRadius;
	bool IsFastMissleModeEnabled;
}

struct BattlefieldInfo
{
	int RoundNumber;
	string BotId;
	BoardTile[][] Board;

	string BotLocation;
	bool IsMissleAvailable;
	string[] OpponentLocations;

	Bomb[] Bombs;
	Missle[] Missles;

	.GameConfig GameConfig;
}

struct Move
{
	MoveDirection Direction;
	BotAction Action;
	MoveDirection FireDirection; 
}

struct Point
{
	this(string s){
		this = s.toPoint;
	}
	this(int xx, int yy){
		x = xx;
		y = yy;
	}
	int x, y;
}

Point toPoint(string s) {
	import std.regex;
	auto rx = ctRegex!("(%d), (%d)");
	auto m = s.matchAll(rx);
	return Point(m.front[0].to!int, m.front[1].to!int);
}



double test_move(Move[] m, BattlefieldInfo info, int depth)
{
	Move my = m[0];
	Move o = m[1];

	auto p = info.BotLocation.toPoint;


	if(depth > 0){

	}

	return 0.5;
}

auto test_moves(BattlefieldInfo info, int depth)
{
	//return gen_moves.map!(e => tuple(e, test_move(e.array, info, depth)));
}

auto gen_moves()
{
	//immutable Move[] moves = [
	//	Move(MoveDirection.None,	BotAction.None, 		MoveDirection.Up),
	//	Move(MoveDirection.Up,		BotAction.None, 		MoveDirection.Up),
	//	Move(MoveDirection.Down,	BotAction.None, 		MoveDirection.Up),
	//	Move(MoveDirection.Right,	BotAction.None, 		MoveDirection.Up),
	//	Move(MoveDirection.Left,	BotAction.None, 		MoveDirection.Up),
	//	Move(MoveDirection.None,	BotAction.DropBomb,		MoveDirection.Up),
	//	Move(MoveDirection.Up,		BotAction.DropBomb, 	MoveDirection.Up),
	//	Move(MoveDirection.Down,	BotAction.DropBomb, 	MoveDirection.Up),
	//	Move(MoveDirection.Right,	BotAction.DropBomb, 	MoveDirection.Up),
	//	Move(MoveDirection.Left,	BotAction.DropBomb, 	MoveDirection.Up),
	//	Move(MoveDirection.None,	BotAction.FireMissle, 	MoveDirection.Up),
	//	Move(MoveDirection.Up,		BotAction.FireMissle, 	MoveDirection.Up),
	//	Move(MoveDirection.Down,	BotAction.FireMissle, 	MoveDirection.Up),
	//	Move(MoveDirection.Right,	BotAction.FireMissle, 	MoveDirection.Up),
	//	Move(MoveDirection.Left,	BotAction.FireMissle, 	MoveDirection.Up),
	//	Move(MoveDirection.None,	BotAction.FireMissle, 	MoveDirection.Down),
	//	Move(MoveDirection.Up,		BotAction.FireMissle, 	MoveDirection.Down),
	//	Move(MoveDirection.Down,	BotAction.FireMissle, 	MoveDirection.Down),
	//	Move(MoveDirection.Right,	BotAction.FireMissle, 	MoveDirection.Down),
	//	Move(MoveDirection.Left,	BotAction.FireMissle, 	MoveDirection.Down),
	//	Move(MoveDirection.None,	BotAction.FireMissle, 	MoveDirection.Left),
	//	Move(MoveDirection.Up,		BotAction.FireMissle, 	MoveDirection.Left),
	//	Move(MoveDirection.Down,	BotAction.FireMissle, 	MoveDirection.Left),
	//	Move(MoveDirection.Right,	BotAction.FireMissle, 	MoveDirection.Left),
	//	Move(MoveDirection.Left,	BotAction.FireMissle, 	MoveDirection.Left),
	//	Move(MoveDirection.None,	BotAction.FireMissle, 	MoveDirection.Right),
	//	Move(MoveDirection.Up,		BotAction.FireMissle, 	MoveDirection.Right),
	//	Move(MoveDirection.Down,	BotAction.FireMissle, 	MoveDirection.Right),
	//	Move(MoveDirection.Right,	BotAction.FireMissle, 	MoveDirection.Right),
	//	Move(MoveDirection.Left,	BotAction.FireMissle, 	MoveDirection.Right)
	//];
	
	auto n = [EnumMembers!MoveDirection].map!(e => tuple(e, BotAction.None, MoveDirection.None));
	auto d = [EnumMembers!MoveDirection].map!(e => tuple(e, BotAction.DropBomb, MoveDirection.None));
	auto f = [EnumMembers!MoveDirection].map!(e => 
		[
			MoveDirection.Up, 
			MoveDirection.Down, 
			MoveDirection.Left, 
			MoveDirection.Right
		].map!(f => tuple(e, BotAction.FireMissle, f))).joiner;
	auto moves = chain(n,d,f);
	
	auto all = moves.map!(e => moves.map!(f => [e, f]));
	return all;
}

auto rndAction()
{
	import std.random;
	int x = uniform(0, 512);
	if(x <= BotAction.max){
		return x.to!BotAction;
	}
	return BotAction.None;
}

auto make_move(BattlefieldInfo info)
{
	import std.random;
	//info.GameConfig.to!string.writeln;
	//test_moves(info, 0);

	return Move(uniform!MoveDirection(), rndAction, uniform(0, 3).to!MoveDirection);
}

