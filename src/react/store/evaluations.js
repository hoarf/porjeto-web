import { createStore } from "redux";
import rootReducer from "../reducers/evaluations";

const store = createStore(rootReducer);

export default store;
