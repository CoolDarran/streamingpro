package streaming.core.strategy.platform

import java.util.concurrent.atomic.AtomicReference
import java.util.{Map => JMap}

import streaming.core.strategy.platform._

/**
  * @author danran
  * @since 03/08/2017
  */
class LocalRuntime(_params: JMap[Any, Any]) extends StreamingRuntime with PlatformManagerListener {
  self =>

  def name = "Local"

  override def startRuntime: StreamingRuntime = { this }

  override def destroyRuntime(stopGraceful: Boolean, stopContext: Boolean): Boolean = false

  override def streamingRuntimeInfo: StreamingRuntimeInfo = null

  override def resetRuntimeOperator(runtimeOperator: RuntimeOperator): Unit = {}

  override def configureStreamingRuntimeInfo(streamingRuntimeInfo: StreamingRuntimeInfo): Unit = {}

  override def awaitTermination: Unit = {}

  override def startThriftServer: Unit = {}

  override def startHttpServer: Unit = {}

  override def params: JMap[Any, Any] = _params

  override def processEvent(event: Event): Unit = {}
}

object LocalRuntime {

  private val INSTANTIATION_LOCK = new Object()

  /**
    * Reference to the last created SQLContext.
    */
  @transient private val lastInstantiatedContext = new AtomicReference[LocalRuntime]()

  /**
    * Get the singleton SQLContext if it exists or create a new one using the given SparkContext.
    * This function can be used to create a singleton SQLContext object that can be shared across
    * the JVM.
    */
  def getOrCreate(params: JMap[Any, Any]): LocalRuntime = {
    INSTANTIATION_LOCK.synchronized {
      if (lastInstantiatedContext.get() == null) {
        setLastInstantiatedContext(new LocalRuntime(params))
      }
    }
    PlatformManager.getOrCreate.register(lastInstantiatedContext.get())
    lastInstantiatedContext.get()
  }

  private[platform] def clearLastInstantiatedContext(): Unit = {
    INSTANTIATION_LOCK.synchronized {
      PlatformManager.getOrCreate.unRegister(lastInstantiatedContext.get())
      lastInstantiatedContext.set(null)
    }
  }

  private[platform] def setLastInstantiatedContext(localRuntime: LocalRuntime): Unit = {
    INSTANTIATION_LOCK.synchronized {
      lastInstantiatedContext.set(localRuntime)
    }
  }
}
