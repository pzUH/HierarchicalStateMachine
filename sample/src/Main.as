package 
{
	/* example of HSM
	 * 
	 * agent: Bob the Miner
	 * 
	 * number of states: 8
	 * number of composite states: 3
	 * number of atomic states: 5
	 * 
	 * composite states:
		 * AtHome
		 * AtMine
		 * Dig
		 * 
	 *	atomic states:
		 * PutGold
		 * Search
		 * Sleep
		 * SmashRock
		 * WatchTV
		 * 
	 *
	 * state diagram:
		 * 	too complex to draw here. :D
		 *  so follow this link: http://lh3.ggpht.com/-LIRE2yV8GMc/Ttjr3kDM5gI/AAAAAAAAAZU/_qws12N7ycc/HSMMiner9.jpg?imgmax=800
	 * 
	 * */
	
	import entity.Miner;
	
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	public class Main extends Sprite 
	{
		private var myMiner:Miner;
		
		private var updateTimer:Timer;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			myMiner = new Miner();
			
			updateTimer = new Timer(1000, 0);
			updateTimer.addEventListener(TimerEvent.TIMER, updateTimerHandler, false, 0, true);
			updateTimer.start();
		}
		
		private function updateTimerHandler(event:TimerEvent):void
		{
			myMiner.update();
		}
	}	
}