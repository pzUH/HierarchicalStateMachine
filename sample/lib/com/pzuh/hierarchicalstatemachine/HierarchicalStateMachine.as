package com.pzuh.hierarchicalstatemachine
{
	public class HierarchicalStateMachine 
	{
		private var currentState:BaseHSMState;	
		
		public function HierarchicalStateMachine() 
		{
			currentState = null;
		}	
		
		public function update():void
		{
			currentState.update();
			
			updateAllParentState(currentState);
		}
		
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
	}
}