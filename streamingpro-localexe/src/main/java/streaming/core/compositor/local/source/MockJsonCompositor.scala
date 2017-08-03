package streaming.core.compositor.local.source

import java.util

import net.sf.json.JSONObject
import org.apache.log4j.Logger
import serviceframework.dispatcher.{Compositor, Processor, Strategy}

import scala.collection.JavaConversions._

/**
  * @author danran
  * @since 03/08/2017
  */
class MockJsonCompositor[T] extends Compositor[T] {

  private var _configParams: util.List[util.Map[Any, Any]] = _

  val logger = Logger.getLogger(classOf[MockJsonCompositor[T]].getName)

  def data = {
    _configParams.map(f => JSONObject.fromObject(f).toString()).toSeq
  }

  override def initialize(typeFilters: util.List[String], configParams: util.List[util.Map[Any, Any]]): Unit = {
    this._configParams = configParams
  }

  override def result(alg: util.List[Processor[T]], ref: util.List[Strategy[T]], middleResult: util.List[T], params: util.Map[Any, Any]): util.List[T] = {
    List(data.asInstanceOf[T])
  }
}
