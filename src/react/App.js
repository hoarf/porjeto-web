import React from "react";
import ReactDOM from "react-dom";
import store from "./store/evaluations";
import Evaluations from "./components/evaluations";
import  ApolloClient  from "apollo-boost";
import { ApolloProvider } from "react-apollo";

const client = new ApolloClient({uri: "http://localhost:4000/api"});

const App = () => {
  return (
      <ApolloProvider client={client}>
        <Evaluations/>
      </ApolloProvider>
  );
};

export default App;

ReactDOM.render(<App />, document.getElementById("app"));
