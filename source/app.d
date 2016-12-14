import vibe.d;
import std.json;
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
	
	void getInfo(HTTPServerRequest req, HTTPServerResponse res) 
	{
		auto json = Info("kq", "/static/kq.png", "kq's bot", "TankBlaster");
		res.writeJsonBody(json);
	}

	void postperformNextMove(HTTPServerRequest req, HTTPServerResponse res) 
	{

	}
}
