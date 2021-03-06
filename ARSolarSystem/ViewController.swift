//
//  ViewController.swift
//  ARSolarSystem
//
//  Created by Kioja Kudumu on 11/22/17.
//  Copyright © 2017 Kioja Kudumu. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    let baseNode = SCNNode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        let sun = createPlanet(radius: 0.25, image: "sun")
        sun.position = SCNVector3(x:0, y: 0, z: 0)
        rotateObject(rotation: -0.3, planet: sun, duration: 1)
        
        
        let mercuryRing = createRings(ringSize: 0.3)
        let venusRing = createRings(ringSize: 0.5)
        let earthRing = createRings(ringSize: 0.7)
        let marsRing = createRings(ringSize: 0.8)
        let jupiterRing = createRings(ringSize: 1)
        let saturnRing = createRings(ringSize: 1.25)
        let uranusRing = createRings(ringSize: 1.5)
        let neptuneRing = createRings(ringSize: 1.7)
        
        
        let mercury = createPlanet(radius: 0.03, image: "mercury")
        let venus = createPlanet(radius: 0.04, image: "venus")
        let earth = createPlanet(radius: 0.05, image: "earth")
        let mars = createPlanet(radius: 0.03, image: "mars")
        let jupiter = createPlanet(radius: 0.12, image: "jupiter")
        let saturn = createPlanet(radius: 0.09, image: "saturn")
        let uranus = createPlanet(radius: 0.07, image: "uranus")
        let neptune = createPlanet(radius: 0.08, image: "neptune")
        
        //x axis must be same as ring size
        mercury.position = SCNVector3(x: 0.3, y: 0, z: 0)
        venus.position = SCNVector3(x: 0.5, y: 0, z: 0)
        earth.position = SCNVector3(x: 0.7, y: 0, z: 0)
        mars.position = SCNVector3(x: 0.8, y: 0, z: 0)
        jupiter.position = SCNVector3(x: 1, y: 0, z: 0)
        saturn.position = SCNVector3(x: 1.25, y: 0, z: 0)
        uranus.position = SCNVector3(x: 1.5, y: 0, z: 0)
        neptune.position = SCNVector3(x: 1.7, y: 0, z: 0)
        
        
        rotateObject(rotation: 0.6, planet: mercury, duration: 0.4)
        rotateObject(rotation: 0.4, planet: venus, duration: 0.4)
        rotateObject(rotation: 0.25, planet: earth, duration: 0.4)
        rotateObject(rotation: 0.2, planet: mars, duration: 0.4)
        rotateObject(rotation: 0.45, planet: jupiter, duration: 0.4)
        rotateObject(rotation: 0.34, planet: saturn, duration: 0.4)
        rotateObject(rotation: 0.25, planet: uranus, duration: 0.4)
        rotateObject(rotation: 0.2, planet: neptune, duration: 0.4)
        
        //Rotation is the same as rotation of planet
        rotateObject(rotation: 0.6, planet: mercuryRing, duration: 1)
        rotateObject(rotation: 0.4, planet: venusRing, duration: 1)
        rotateObject(rotation: 0.25, planet: earthRing, duration: 1)
        rotateObject(rotation: 0.2, planet: marsRing, duration: 1)
        rotateObject(rotation: 0.45, planet: jupiterRing, duration: 1)
        rotateObject(rotation: 0.34, planet: saturnRing, duration: 1)
        rotateObject(rotation: 0.25, planet: uranusRing, duration: 1)
        rotateObject(rotation: 0.2, planet: neptuneRing, duration: 1)
        
        let moon = createPlanet(radius: 0.01, image: "moon")
        let moonRing = SCNTorus(ringRadius: 0.08, pipeRadius: 0.000001)
        let moonRingNode = SCNNode(geometry: moonRing)
        moon.position = SCNVector3(x: 0.08, y: 0, z: 0)
        moonRingNode.position = SCNVector3(0, 0.02, 0)
        
        
        let saturn_loop = SCNBox(width: 0.4, height: 0, length: 0.5, chamferRadius: 0)
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "saturn_loop.png")
        saturn_loop.materials = [material]
        
        let loopNode = SCNNode(geometry: saturn_loop)
        loopNode.rotation = SCNVector4(-0.5, -0.5, 0, 0.56)
        loopNode.position = SCNVector3(x: 0, y: 0, z: 0)
        
        moonRingNode.addChildNode(moon)
        
        mercuryRing.addChildNode(mercury)
        venusRing.addChildNode(venus)
        earthRing.addChildNode(earth)
        earth.addChildNode(moonRingNode)
        marsRing.addChildNode(mars)
        jupiterRing.addChildNode(jupiter)
        saturnRing.addChildNode(saturn)
        saturn.addChildNode(loopNode)
        uranusRing.addChildNode(uranus)
        neptuneRing.addChildNode(neptune)
        

        baseNode.addChildNode(sun)
        baseNode.addChildNode(mercuryRing)
        baseNode.addChildNode(venusRing)
        baseNode.addChildNode(earthRing)
        baseNode.addChildNode(marsRing)
        baseNode.addChildNode(jupiterRing)
        baseNode.addChildNode(saturnRing)
        baseNode.addChildNode(uranusRing)
        baseNode.addChildNode(neptuneRing)
        
        
        baseNode.position = SCNVector3(x: 0,y: -0.5, z: -1)
        
        
        
        
        // Create a new scene
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
        
        sceneView.scene.rootNode.addChildNode(baseNode)
    }
    
    func createPlanet(radius: Float, image: String) -> SCNNode {
        let planet = SCNSphere(radius: CGFloat(radius))
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "\(image).jpg")
        planet.materials = [material]
        
        let planetNode = SCNNode(geometry: planet)
        
        return planetNode
    }
    
    func rotateObject(rotation: Float, planet: SCNNode, duration: Float) {
        
        let rotation = SCNAction.rotateBy(x: 0, y: CGFloat(rotation), z: 0, duration: TimeInterval(duration))
        
        planet.runAction(SCNAction.repeatForever(rotation))
        
    }
    
    func createRings(ringSize: Float) -> SCNNode {
        let ring = SCNTorus(ringRadius: CGFloat(ringSize), pipeRadius: 0.002)
        
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.darkGray
        ring.materials = [material]
        
        let ringNode = SCNNode(geometry: ring)

        return ringNode
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
