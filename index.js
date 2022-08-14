// main index.js

// import { NativeModules } from 'react-native';

// const { ReactNativeDatepickerFabric } = NativeModules;

// export default ReactNativeDatepickerFabric;


// const isFabricEnabled = global.nativeFabricUIManager != null;

// import RTDatePickerFabric from './DatePickerNativeComponent';
// console.log(RTDatePickerFabric);

// @flow

// import { requireNativeComponent } from 'react-native'

// const isFabricEnabled = global.nativeFabricUIManager != null;

// const RTDatePickerFabric = isFabricEnabled ?
//   require("./src/BTDatePickerNativeComponent").default :
//   requireNativeComponent("ColoredView")


const RTDatePickerFabric = require("./src/BTDatePickerNativeComponent").default

export default RTDatePickerFabric;