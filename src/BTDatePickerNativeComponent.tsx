import {HostComponent, ViewProps} from "react-native"
import type {
  Int32,
  Double,
  WithDefault,
  BubblingEventHandler
} from "react-native/Libraries/Types/CodegenTypes"
// import codegenNativeComponent from 'react-native/Libraries/Utilities/codegenNativeComponent';

import codegenNativeComponentUntyped from "react-native/Libraries/Utilities/codegenNativeComponent"

const codegenNativeComponent = codegenNativeComponentUntyped as <T extends {}>(
  name: string
) => HostComponent<T>

type DatePickerEvent = Readonly<{
  timestamp: Double
}>

type DateMode = "date" | "time" | "datetime"

interface BTDatePickerProps extends ViewProps {
  mode?: WithDefault<DateMode, "date">
  date: Double
  minimumDate?: Double
  maximumDate?: Double
  minuteInterval?: Int32
  onChange: BubblingEventHandler<DatePickerEvent>
}

export default codegenNativeComponent<BTDatePickerProps>("BTDatePickerView")
