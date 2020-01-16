import React, { useState } from 'react';
import { StyleSheet, Text, View, ScrollView } from 'react-native';

export default function App() {

  const [people, setPeople] = useState([
    { name: 'shaun', key: '5' },
    { name: 'kevin', key: '8' },
    { name: 'brian', key: '2' },
    { name: 'kate', key: '4' },
    { name: 'ian', key: '2' },
    { name: 'smith', key: '6' }
  ]);


  return (
    <View style={styles.container}>

      <ScrollView>
      { people.map((item, index) => {
        return (
            <View key={index}>
              <Text style={styles.item}>{item.name}</Text>
            </View>
          )
      })}
      </ScrollView>

      

    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    paddingTop: 40,
    paddingHorizontal: 20

    // alignItems: 'center',
    // justifyContent: 'center',
  },
  item: {
    marginTop: 24,
    padding: 30,
    backgroundColor: 'pink',
    fontSize: 24
  }

});
