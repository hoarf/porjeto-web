import React from "react";
import ReactDOM from "react-dom";
import store from "./store/evaluations";
import Evaluations from "./components/evaluations";
import { Provider } from "react-redux";

const App = () => {
  return (
      <Provider store={store}>
        <Evaluations/>
      </Provider>
  );
};

export default App;

ReactDOM.render(<App />, document.getElementById("app"));
