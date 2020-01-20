import React, { useState } from 'react';
import { StyleSheet, Text, View, FlatList } from 'react-native';

export default function App() {

  const [people, setPeople] = useState([
    { name: 'shaun', id: '5' },
    { name: 'kevin', id: '8' },
    { name: 'brian', id: '2' },
    { name: 'kate', id: '4' },
    { name: 'ian', id: '2' },
    { name: 'smith', id: '6' }
  ]);


  return (
    <View style={styles.container}>


      <FlatList
          numColumns={2}
          keyExtractor={(item) => item.id}
          data={people}
          renderItem={({ item }) => (
            <Text style={styles.item}>{item.name}</Text>
          )}
        />
      

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
    fontSize: 24,
    marginHorizontal: 10,
    marginTop: 24


  }

});
