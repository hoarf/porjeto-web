import React, { Component } from "react";
import { connect } from "react-redux";
import { showEvaluation } from "../actions/evaluations";

const mapDispatchToProps = dispatch => {
    return {
        showEvaluation: evaluation => dispatch(showEvaluation(evaluation))
    };
};

const mapStateToProps = state => {
    return { evaluations: state.evaluations };
};

const ConnectedList = ({ evaluations }) => (
    evaluations.map(el => (
            <div>
            <div>{ el.email }</div>
            </div>
    ))
);

const Evaluations = connect(mapStateToProps)(ConnectedList);

export default Evaluations;
