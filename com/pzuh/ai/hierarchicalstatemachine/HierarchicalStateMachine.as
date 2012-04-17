package com.pzuh.ai.hierarchicalstatemachine
{
	public class HierarchicalStateMachine 
	{
		private var currentState:BaseHSMState;	
		
		public function HierarchicalStateMachine() 
		{
			currentState = null;
		}	
		
		//call this method in the game main loop to update the state machine
		public function update():void
		{
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
		
		public function changeState(targetState:BaseHSMState):void
		{
			if (currentState != null)
			{
				currentState.exit();
				exitParentState(currentState, targetState.getLevel());
				
				currentState = null;
			}
			
			currentState = getLowestLevelState(targetState);
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
		
		public function removeSelf():void
		{
			currentState = null;
		}
	}
}