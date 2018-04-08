/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  Button
} from 'react-native';

export default class rnFirst extends Component {
  constructor(props) {
    super(props)
    this.state = {
      fetchData: 'null'
    }
  }
  fetch = async () => {
    try{
      const response = await fetch('https://www.baidu.com/home/xman/data/tipspluslist?indextype=manht&_req_seqid=0xb512f83600013de7&asyn=1&t=1517973897251&sid=1452_21115_18560_17001_22074')
      const res = await response.json()
      console.log(res, 'fetch return')
      this.setState({fetchData: JSON.stringify(res)})
    }catch(e) {
      console.log(e, 'fetch error')
    }
  }

  render() {
    console.log('render')
    // this.fetch()
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>
          Welcome to React Native!
        </Text>
        <Text style={styles.instructions}>
          To get started, edit index.ios.js
        </Text>
        <Text style={styles.instructions}>
          Press Cmd+R to reload,{'\n'}
          Cmd+D or shake for dev menu
        </Text>
        <Text style={styles.box}>
          fetch return: {this.state.fetchData}
        </Text>
        <Button onPress={this.fetch} title="submit"/>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
  box: {
    backgroundColor: '#eee',
    margin: 20,
    padding: 20,
    borderRadius: 10,
  }
});

AppRegistry.registerComponent('rnFirst', () => rnFirst);
