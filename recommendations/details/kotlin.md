# Kotlin

Here's a good lecture with comparison overview: [Kotlin vs Scala](https://www.youtube.com/watch?v=MsMejigb1Zk)

Here are some lectures from Google I/O to get some idea about Kotlin:

[Introduction to Kotlin (Google I/O '17)](https://www.youtube.com/watch?v=X1RVYt2QKQE)

[How to Kotlin - from the Lead Kotlin Language Designer (Google I/O '18)](https://www.youtube.com/watch?v=6P20npkvcb8) 

Here are main arguments/advantages of Kotlin over Scala

1. Kotlin design is simpler then Scala design - allowing flatter learning curve.

2. Kotlin has high level of interop with Java:

    * Existing battle-checked Java frameworks can be leveraged directly from Kotlin.

    * Code written in Kotlin can be used directly from Java. Less risky to introduce Kotlin with an option to go back to Java at any moment.

    * Existing codebase in Java could be converted to Kotlin at almost zero cost (even with one click in IntelliJ IDEA).

    * Easy to adopt at other areas, like QA automation.

3. Kotlin is one of two (golang as well) industrial languages that have coroutines.

4. Kotlin is multiplatform (implemented by vendor) - could be used for wide variety of tasks even where heavy JVM is not applicable.

5. Kotlin outside of Android is pretty fresh - should help to get the attention of talented engineers and define Moda Operandi as a technology driven company.

6. Kotlin is newest in JVM space - it has opportunity for developers to make an impact by contributing more in open source.

Here are some main Kotlin features:
- immutability control
   ```kotlin
   val a = "some string"

   a = "some other string" // won't compile a is immutable
   ```
- true null safety
   ```kotlin
   val a: String = null // won't compile String is not nullable type

   val b: String? = null // this is fine String? is nullable

   val len = b.length // this won't compile b needs to be checked for null value first

   if (b != null) {
      val len = b.length // this is fine b is smartcasted to String type 
   }
   ```
- type inference
   ```kotlin
   val a = "some string" // a type is inferred as String
   val b: String = "some other string" // explicit type info is fine too
   ```
- data types
   ```kotlin
   data class Point(val x: Int, val y: Int) // class with two properties and equality
   ```
- extension functions
   ```kotlin
   fun MutableList<Int>.swap(index1: Int, index2: Int) { // this is extension function to MutableList
      val tmp = this[index1] // 'this' corresponds to the list
      this[index1] = this[index2]
      this[index2] = tmp
   }

   val l = mutableListOf(1, 2, 3)
   l.swap(0, 2) // 'this' inside 'swap()' will hold the value of 'l'
   ```
- function types
   ```kotlin
   fun <T, R> Collection<T>.fold(
      initial: R, 
      combine: (acc: R, nextElement: T) -> R // function type here
   ): R {
      var accumulator: R = initial
      for (element: T in this) {
         accumulator = combine(accumulator, element)
      }
      return accumulator
   }

   val items = listOf(1, 2, 3, 4, 5)

   val joinedToString = items.fold("Elements:", { acc, i -> acc + " " + i }) // lambda function passed here

   val product = items.fold(1, Int::times) // function reference passed here
   ```
- sealed classes with (very) limited pattern matching
   ```kotlin
   sealed class Expr
   data class Const(val number: Double) : Expr()
   data class Sum(val e1: Expr, val e2: Expr) : Expr()
   object NotANumber : Expr()

   fun eval(expr: Expr): Double = when(expr) {
      is Const -> expr.number
      is Sum -> eval(expr.e1) + eval(expr.e2)
      NotANumber -> Double.NaN
      // the `else` clause is not required because we've covered all the cases
   }
   ```
- coroutines
   ```kotlin
   suspend fun workload(n: Int): Int { // may be executed as suspendable lightweight thread - coroutine
      delay(1000)
      return n
   }```
- all same libraries and frameworks from Java are available with full interop
- there's a lot of work going on at kotlinx libraries space - these libraries are truly multiplatform
- libraries built specifically for Kotlin: Ktor, Koin and some nice DSL addons for existing libraries usable from Kotlin
