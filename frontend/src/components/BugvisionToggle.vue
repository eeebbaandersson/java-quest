<script setup>
import { useBugHunting } from "@/composables/useBugHunting";

const { isBugVisionActive, setBugVision } = useBugHunting();
</script>


<template>
  <div class="toggle-container">
    <span class="toggle-label">BUG VISION</span>
    <label class="switch">
      <input 
        type="checkbox" 
        :checked="isBugVisionActive" 
        @change="setBugVision($event.target.checked)" 
      />
      <span class="slider">
        <span class="badge-icon-mask icon-bug toggle-icon"></span>
      </span>
    </label>
  </div>
</template>

<style scoped>

.toggle-container {
  display: flex;
  flex-direction: row;
  align-items: center;
  gap: 0.6rem;
  font-family: var(--font-mono, sans-serif);
}

.toggle-label {
  font-size: 0.75rem;
  font-weight: 600;
  color: rgba(255, 255, 255, 0.8);
  letter-spacing: 0.5px;
}


.switch {
  position: relative;
  display: inline-block;
  width: 54px;
  height: 28px;
}

.switch input {
  opacity: 0;
  width: 0;
  height: 0;
}

.slider {
  position: absolute;
  cursor: pointer;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
   background-color: rgba(255, 255, 255, 0.02);
  backdrop-filter: blur(8px);
  -webkit-backdrop-filter: blur(8px);
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 34px;
  transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1);
}

.toggle-icon {
  position: absolute;
  right: 7px;  
  top: 50%;
  transform: translateY(-50%);               
  width: 14px;                
  height: 14px;
  background-color: var(--text-muted, rgba(255, 255, 255, 0.5)); 
  pointer-events: none;
  transition: opacity 0.25s ease;
  z-index: 1;                 
}

.slider::before {
  position: absolute;
  content: "";
  height: 22px;
  width: 22px;
  left: 2px;
  top: 2px;
  background-color: #ffffff;
  border-radius: 50%;
  transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1);
  z-index: 2;         
}


.switch input:checked + .slider {
  background-color: rgba(74, 222, 128, 0.2);
  border-color: #4ade80;
  box-shadow: 0 0 12px rgba(74, 222, 128, 0.4), inset 0 0 8px rgba(74, 222, 128, 0.2);
}

.switch input:checked + .slider::before {
  transform: translateX(24px);
  background-color: #ffffff;
  box-shadow: 0 0 8px rgba(74, 222, 128, 0.6); 
}

.switch input:checked + .slider .toggle-icon {
  opacity: 0;
}


.switch:hover .slider {
  border-color: rgba(255, 255, 255, 0.4);
}

.badge-icon-mask {
  width: 14px;
  height: 14px;
  display: inline-block;
  background-color: currentColor;
  -webkit-mask-repeat: no-repeat;
  mask-repeat: no-repeat;
  -webkit-mask-position: center;
  mask-position: center;
  -webkit-mask-size: contain;
  mask-size: contain;
}

.icon-bug {
  -webkit-mask-image: url("@/assets/icons/bug.svg");
  mask-image: url("@/assets/icons/bug.svg");
   color: rgba(255, 255, 255, 0.25); 
}
</style>