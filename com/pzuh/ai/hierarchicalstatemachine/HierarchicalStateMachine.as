package com.pzuh.ai.hierarchicalstatemachine
{
	public class HierarchicalStateMachine 
	{
		private var currentState:BaseHSMState;	
		
		private var stateArray:Array = new Array();
		
		public function HierarchicalStateMachine() 
		{
			currentState = null;
		}	
		
		public function addState(...rest):void
		{
			for (var i:int = 0; i < rest.length; i++)
			{
				if (stateArray.indexOf(rest[i]) == -1)
				{
					stateArray.push(rest[i]);
				}
			}
		}
		
		//call this method in the game main loop to update the state machine
		public function update():void
		{
			if (currentState == null)
			{
				return;
			}
			
			currentState.update();
			
			updateAllParentState(currentState);
		}
		
		//aside of updating the current state, it also updating all of current state's predecessor state
		private function updateAllParentState(currentState:BaseHSMState):void
		{
			if (currentState.getParent() != null)
			{
				currentState.getParent().update();
				
				updateAllParentState(currentState.getParent());
			}
		}
		
		public function changeState(targetState:String):void
		{
			var nextState:BaseHSMState = getState(targetState);		
			
			if (currentState != null)
			{
				currentState.exit();
				exitParentState(currentState, nextState.getLevel());
				
				currentState = null;
			}
			
			currentState = getLowestLevelState(nextState);
			currentState.enter();
		}
		
		//we need to exit all of the current state's predecessor state, so we call this method on the changeState() method
		public function exitParentState(currentState:BaseHSMState, level:int):void
		{
			if (currentState.getParent() != null)
			{
				if (currentState.getLevel() > level)
				{
					currentState.getParent().exit();
					
					exitParentState(currentState.getParent(), level);
				}
			}
		}
		
		//go to the lowest level state (a state which have no child)
		public function getLowestLevelState(targetState:BaseHSMState):BaseHSMState
		{
			var tempState:BaseHSMState;
			
			if (targetState != null)
			{
				if (targetState.getInitState() != null) 
				{
					targetState.enter();
					tempState = getLowestLevelState(targetState.getInitState());
				}
				else
				{
					tempState = targetState;
				}
			}			
			
			return tempState;
		}
		
		public function getCurrentState():BaseHSMState
		{
			return currentState;
		}
		
		public function getState(name:String):BaseHSMState
		{
			for (var i:int = 0; i < stateArray.length; i++)
			{
				if (stateArray[i].getName() == name)
				{
					return stateArray[i];
				}
			}
			
			return null;
		}
		
		public function removeSelf():void
		{
			for (var i:int = stateArray.length - 1; i >= 0; i--)
			{
				stateArray[i].removeSelf();
				stateArray.splice(i, 1);
			}
			
			stateArray = null;
			
			currentState = null;
		}
	}
}