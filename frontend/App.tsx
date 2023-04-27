import { ClerkProvider } from "@clerk/clerk-expo";
import { StatusBar } from "expo-status-bar";
import { StyleSheet, Text, View } from "react-native";
import { CLERK_PUBLISHABLE_KEY } from "@env";

export default function App() {
  return (
    <ClerkProvider publishableKey="pk_test_ZGlzY3JldGUtY3JheWZpc2gtMzcuY2xlcmsuYWNjb3VudHMuZGV2JA">
      <View style={styles.container}>
        <Text>
          Open up App.tsx to start {CLERK_PUBLISHABLE_KEY} working on your app!
        </Text>
        <StatusBar style="auto" />
      </View>
    </ClerkProvider>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#fff",
    alignItems: "center",
    justifyContent: "center",
  },
});
