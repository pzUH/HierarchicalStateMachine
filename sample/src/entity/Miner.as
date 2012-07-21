package entity 
{
	import state.*;
	import compositeState.*;
	
	import com.pzuh.ai.hierarchicalstatemachine.*;
	
	public class Miner 
	{
		private var myStateMachine:HierarchicalStateMachine;
		
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
		}
		
		//this is the example for initializing the state machine
		private function initState():void
		{
			myStateMachine = new HierarchicalStateMachine();
			
			//initialize all atomic state first so it can added to the composite states
			var searchState:BaseHSMState = new SearchState(this, SEARCH_STATE);
			var smashRockState:BaseHSMState = new SmashRockState(this, SMASH_ROCK_STATE);
			var putGoldState:BaseHSMState = new PutGoldState(this, PUT_GOLD_STATE);
			var sleepState:BaseHSMState = new SleepState(this, SLEEP_STATE);
			var watchTVState:BaseHSMState = new WatchTVState(this, WATCH_TV_STATE);
			
			//initialize all composite states, and don't forget to add all of their respective children
			var digState:BaseHSMState = new DigState(this, DIG_STATE);	
			digState.addChildState(smashRockState);
			digState.addChildState(putGoldState);
			
			var atMineState:BaseHSMState = new AtMineState(this, AT_MINE_STATE);
			atMineState.addChildState(digState);
			atMineState.addChildState(searchState);	
			
			//This shows how to define transition outside the concrete class
			atMineState.addTransition(AT_HOME_STATE, goHome);
			
			/*atHomeState doesn't have any concrete state class.
			I just want to show you how to create a state without creating a concrete state
			So you'll need to define its transitions also the actions*/
			var atHomeState:BaseHSMState = new BaseHSMState(this, AT_HOME_STATE);	
			atHomeState.addChildState(watchTVState);
			atHomeState.addChildState(sleepState);			
			
			//define the transitions and actions
			atHomeState.addTransition(AT_MINE_STATE, goToTheMine);			
			atHomeState.addAction(inHome, enterHome, exitHome);
			
			//store the states to stateArray
			myStateMachine.addState(
			atHomeState, atMineState, digState, watchTVState, sleepState, putGoldState, smashRockState, searchState);
			
			//set the initial state
			myStateMachine.changeState(AT_HOME_STATE);
		}
		
		public function update():void
		{
			//don't forget to call update method, so the machine will be updated regularly.
			myStateMachine.update();
		}
		
		public function changeState(state:String):void
		{
			myStateMachine.changeState(state);
		}
		
		private function goHome():Boolean
		{
			var prob:int = Math.ceil(Math.random() * 15);
			
			if (prob == 1)
			{
				return true;
			}
			
			return false;
		}
		
		private function enterHome():void
		{
			trace("Bob: Entering mah home");
		}
		
		private function exitHome():void
		{
			trace("Bob: Leavin' mah tiny old shack");
		}
		
		private function inHome():void
		{
			trace("Bob: Home sweet home");
		}
		
		private function goToTheMine():Boolean
		{
			var prob:int = Math.ceil(Math.random() * 15);
			
			if (prob == 1)
			{
				return true;
			}
			
			return false;
		}
		
		public function removeSelf():void
		{
			myStateMachine.removeSelf();
			myStateMachine = null;
		}
	}
}