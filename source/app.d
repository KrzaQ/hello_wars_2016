import std.algorithm;
import std.conv;
import std.format;
import std.json;
import std.range;
import std.stdio;
import std.string;

import vibe.d;

import painlessjson;


shared static this()
{
	auto settings = new HTTPServerSettings;
	settings.port = 8080;
	settings.bindAddresses = ["0.0.0.0"];
	
	auto router = new URLRouter;

	router.registerWebInterface(new WebInterface);
	router.get("*", serveStaticFiles("public/"));

	listenHTTP(settings, router);

	//listenHTTP(settings, &hello);

	//logInfo("Please open http://127.0.0.1:8080/ in your browser.");
}


class WebInterface
{
	struct Info{ string Name, AvatarUrl, Description, GameType; };

	//struct 
	
	void get(HTTPServerRequest req, HTTPServerResponse res){ res.writeBody(""); }

	void getInfo(HTTPServerRequest req, HTTPServerResponse res) 
	{
		auto json = Info("kq", "http://10.254.239.16:8080/static/kq.png", "kq's bot", "TankBlaster");
		res.writeJsonBody(json);
	}

	@path("/PerformNextMove")
	void postPerformNextMove(HTTPServerRequest req, HTTPServerResponse res) 
	{
		import make_move;
		auto m = make_move.make_move(fromJSON!BattlefieldInfo(parseJSON(req.json.to!string)));
		res.writeJsonBody(m);
	}
}
