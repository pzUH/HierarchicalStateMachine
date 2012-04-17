package entity 
{
	import state.*;
	import compositeState.*;
	
	import com.pzuh.ai.hierarchicalstatemachine.*;
	
	public class Miner 
	{
		private var myStateMachine:HierarchicalStateMachine;
		
		private var atMineState:BaseHSMState;
		private var atHomeState:BaseHSMState;
		private var digState:BaseHSMState;
		private var searchState:BaseHSMState;
		private var smashRockState:BaseHSMState;
		private var putGoldState:BaseHSMState;
		private var watchTVState:BaseHSMState;
		private var sleepState:BaseHSMState;
		
		public static const AT_MINE_STATE:String = "at_mine_state";
		public static const AT_HOME_STATE:String = "at_home_state";
		public static const DIG_STATE:String = "dig_state";
		public static const SEARCH_STATE:String = "search_state";
		public static const SMASH_ROCK_STATE:String = "smash_rock_state";
		public static const PUT_GOLD_STATE:String = "put_gold_state";
		public static const WATCH_TV_STATE:String = "watch_tv_state";
		public static const SLEEP_STATE:String = "sleep_state";
		
		public function Miner() 
		{
			initState();
			
			myStateMachine = new HierarchicalStateMachine();
			changeState(AT_HOME_STATE);
		}
		
		private function initState():void
		{
			//init all atomic state first so it can added to the composite states
			searchState = new SearchState(this);
			smashRockState = new SmashRockState(this);
			putGoldState = new PutGoldState(this);	
			sleepState = new SleepState(this);
			watchTVState = new WatchTVState(this);
			
			//init all composite states, and don't forget to add their respective children
			digState = new DigState(this);	
			digState.addChildState(smashRockState);
			digState.addChildState(putGoldState);
			
			atMineState = new AtMineState(this);
			atMineState.addChildState(digState);
			atMineState.addChildState(searchState);			
			
			atHomeState = new AtHomeState(this);	
			atHomeState.addChildState(watchTVState);
			atHomeState.addChildState(sleepState);
		}
		
		public function update():void
		{
			myStateMachine.update();
		}
		
		public function changeState(state:String):void
		{
			var tempState:BaseHSMState;
			
			switch(state)
			{
				case AT_HOME_STATE:
					tempState = atHomeState;
					break;
					
				case AT_MINE_STATE:
					tempState = atMineState;
					break;
					
				case DIG_STATE:
					tempState = digState;
					break;
					
				case SEARCH_STATE:
					tempState = searchState;
					break;
					
				case SMASH_ROCK_STATE:
					tempState = smashRockState;
					break;
					
				case PUT_GOLD_STATE:
					tempState = putGoldState;
					break;
					
				case WATCH_TV_STATE:
					tempState = watchTVState;
					break;
					
				case SLEEP_STATE:
					tempState = sleepState;
					break;
			}
			
			myStateMachine.changeState(tempState);
		}
		
		public function getStateMachine():HierarchicalStateMachine
		{
			return myStateMachine;
		}
		
		public function removeSelf():void
		{
			myStateMachine.removeSelf();
			myStateMachine = null;
			
			//remove all states
			digState.removeSelf();
			atHomeState.removeSelf();
			atMineState.removeSelf();
			putGoldState.removeSelf();
			searchState.removeSelf();
			sleepState.removeSelf();
			smashRockState.removeSelf();
			watchTVState.removeSelf();
			
			digState = null;
			atHomeState = null;
			atMineState = null;
			putGoldState = null;
			searchState = null;
			sleepState = null;
			smashRockState = null;
			watchTVState = null;
		}
	}
}