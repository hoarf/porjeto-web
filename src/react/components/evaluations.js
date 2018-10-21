import React from "react";
import { Query } from "react-apollo";
import gql from "graphql-tag";

const Evaluations = () => (
        <Query query={gql`
        {
          evaluations {
            id
            user {
              email
            }
          }
        }
        `}
        >
        {({loading, error, data}) => {
            if (loading) return <p>loading</p>;
            if (error) return <p>error</p>;
            return data.evaluations.map(({id, user}) => (
                    <div key={id}>{user.email}</div>
            ));
        }}
        </Query>
);

export default Evaluations;
