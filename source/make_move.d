import std.conv;
import std.format;
import std.stdio;
import std.string;

enum MoveDirection
{
	Up, Down, Right, Left
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

void make_move(BattlefieldInfo info)
{
	info.GameConfig.to!string.writeln;
}

