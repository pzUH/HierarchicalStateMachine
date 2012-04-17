package com.pzuh.hierarchicalstatemachine 
{
	public class BaseHSMState
	{
		protected var parentState:BaseHSMState;
		protected var childStateArray:Array;
		protected var initState:BaseHSMState;
		
		protected var level:int;
		
		protected var myEntity:Object
		
		public function BaseHSMState(entity:Object, initState:BaseHSMState = null) 
		{
			childStateArray = new Array();
			
			myEntity = entity;
			
			this.initState = initState;
		}
		
		public function addChildState(state:BaseHSMState):void
		{
			if (childStateArray.indexOf(state) == -1)
			{
				childStateArray.push(state);
				state.parentState = this;
				state.level = this.level + 1;
			}
			else
			{
				throw new Error("ERROR: Duplicate state detected");
			}
		}
		
		private function removeChildState():void
		{
			for (var i:int = 0; i < childStateArray.length; i++)
			{
				childStateArray[i] = null;
				childStateArray.splice(i, 1);
			}
		}
		
		public function removeSelf():void
		{
			removeChildState();
			
			parentState = null;
			initState = null;
			
			myEntity = null;
		}
		
		public function getParent():BaseHSMState
		{
			return parentState;
		}
		
		public function getInitState():BaseHSMState
		{
			return initState;
		}
		
		public function getLevel():int
		{
			return level;
		}
		
		public function enter():void 
		{
			throw new Error("ERROR: This method must be overriden");
		}
		
		public function update():void 
		{
			throw new Error("ERROR: This method must be overriden");
		}
		
		public function exit():void 
		{
			throw new Error("ERROR: This method must be overriden");
		}		
	}
}